const fs = require('fs');
const path = require('path');
const { getOctokit, context } = require('@actions/github');

const QUERIES_DIR = 'comum';
const CONFIG_FILE = 'config.json';

async function getChangedFiles() {
  const token = process.env.GITHUB_TOKEN;
  const octokit = getOctokit(token);
  const { owner, repo } = context.repo;
  const pull_number = context.payload.pull_request ? context.payload.pull_request.number : null;

  let files = [];
  if (pull_number) {
    const { data } = await octokit.pulls.listFiles({
      owner,
      repo,
      pull_number,
    });
    files = data.map(file => ({
      filename: file.filename,
      status: file.status,
      patch: file.patch
    }));
  } else {
    const { data } = await octokit.repos.getCommit({
      owner,
      repo,
      ref: context.sha,
    });
    files = data.files.map(file => ({
      filename: file.filename,
      status: file.status,
      patch: file.patch
    }));
  }

  return files.filter(file => file.filename.startsWith(QUERIES_DIR) && file.filename.endsWith('.sql'));
}

function loadConfig() {
  if (fs.existsSync(CONFIG_FILE)) {
    const data = fs.readFileSync(CONFIG_FILE, 'utf8');
    return JSON.parse(data);
  }
  return { verificacoes: [] };
}

function saveConfig(config) {
  fs.writeFileSync(CONFIG_FILE, JSON.stringify(config, null, 2), 'utf8');
}

async function updateConfig(changedFiles) {
  const config = loadConfig();

  for (const changedFile of changedFiles) {
    const filePath = path.join(QUERIES_DIR, changedFile.filename);
    const fileName = path.basename(changedFile.filename, '.sql').replace(/_/g, ' ');

    if (changedFile.status === 'added') {
      config.verificacoes.push({
        nome: fileName,
        descricao: `Consulta SQL para ${fileName}.`,
        caminho: filePath,
        cron: "0 0 * * *",  // Default para execução diária à meia-noite
        count_only: false   // Default como false
      });
    } else if (changedFile.status === 'modified') {
      const query = config.verificacoes.find(q => q.caminho === filePath);
      if (query) {
        query.nome = fileName;
        query.caminho = filePath;
      }
    } else if (changedFile.status === 'removed') {
      const index = config.verificacoes.findIndex(q => q.caminho === filePath);
      if (index !== -1) {
        config.verificacoes.splice(index, 1);
      }
    }
  }

  saveConfig(config);
}

async function main() {
  const changedFiles = await getChangedFiles();
  await updateConfig(changedFiles);

  console.log(`Arquivo ${CONFIG_FILE} atualizado com sucesso!`);
}

main().catch(error => {
  console.error(error);
  process.exit(1);
});
