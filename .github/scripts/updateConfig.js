const fs = require('fs');
const path = require('path');

const QUERIES_DIR = 'comum';
const CONFIG_FILE = 'config.json';

function getSQLFiles(dir) {
  let results = [];
  const list = fs.readdirSync(dir);

  list.forEach(file => {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);

    if (stat && stat.isDirectory()) {
      results = results.concat(getSQLFiles(filePath));
    } else if (file.endsWith('.sql')) {
      results.push({
        nome: file.replace('.sql', '').replace(/_/g, ' '),
        descricao: `Consulta SQL para ${file.replace('.sql', '').replace(/_/g, ' ')}.`,
        caminho: filePath,
        cron: "0 0 * * *",  // Default para execução diária à meia-noite
        count_only: false   // Default como false
      });
    }
  });

  return results;
}

const queries = getSQLFiles(QUERIES_DIR);
const config = { verificacoes: queries };

fs.writeFileSync(CONFIG_FILE, JSON.stringify(config, null, 2), 'utf8');

console.log(`Arquivo ${CONFIG_FILE} atualizado com sucesso!`);