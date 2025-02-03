const fs = require('fs');
const path = require('path');

const QUERIES_DIR = 'comum';
const CONFIG_FILE = 'config.json';

function getSQLFiles(dir) {
  return fs.readdirSync(dir)
    .filter(file => file.endsWith('.sql'))
    .map(file => ({
      nome: file.replace('.sql', '').replace(/_/g, ' '),
      descricao: `Consulta SQL para ${file.replace('.sql', '').replace(/_/g, ' ')}.`,
      caminho: path.join(QUERIES_DIR, file),
      cron: "0 0 * * *",  // Default para execução diária à meia-noite
      count_only: false   // Default como false
    }));
}

const queries = getSQLFiles(QUERIES_DIR);
const config = { verificacoes: queries };

fs.writeFileSync(CONFIG_FILE, JSON.stringify(config, null, 2), 'utf8');

console.log(`Arquivo ${CONFIG_FILE} atualizado com sucesso!`);
