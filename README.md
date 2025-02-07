# 📁 Diretrizes de Organização do Repositório

Este repositório armazena **consultas SQL** chamadas de **Itens de Verificação**. Para garantir a organização e facilitar a manutenção dos arquivos, siga a estrutura abaixo ao adicionar novos itens ao repositório.

## 📂 Estrutura de Diretórios

A estrutura geral do repositório segue a seguinte organização:

```
/repo-raiz
│── 📂 completude
│   │── 📄 IV-001-CP.sql
│   │── 📄 IV-002-CP.sql
│── 📂 consistencia
│   │── 📄 IV-001-CS.sql
│   │── 📄 IV-002-CS.sql
│  
│── 📄 config.json
```

- **`completude/`**: Na **raiz**, representa um aspecto da qualidade definido na [planilha](https://docs.google.com/spreadsheets/d/1nOGwWIFpqs8BgAdQfdgkpakpKhR1-77unyY0nzfNvv0/edit?gid=0#gid=0).
- **Arquivos dentro de cada pasta de aspecto de qualidade**:
  - `IV002CP.sql` : Arquivo contendo a consulta SQL correspondente ao item.

## ✍🏻 Nomenclatura do item de verificação
Cada item deve ser nomeado seguindo a seguinte regra de nomenclatura:
`IV`-`Id do item na tabela de itens`-`Sigla para aspecto da qualidade`.sql

exemplo: 
  `IV-0001-CP.sql`: representa o Item de Verificação de id 001 da tabela e ele se enquadra no aspécto de qualidade da Completude. 

## 📜 Formato do Arquivo JSON

Na raiz do projeto tem o arquivo `config.json`:

```json
{
  "itens": [
        {
            "nome": "processos-totais",
            "codigo": "IV001CP",
            "descricao": "numero total de processos.",
            "aspecto":"completude",
            "caminho": "completude/IV001CP.sql",
            "filename": "IV001CP.sql",
            "cron": "0 0 * * *",
            "count_only": true,
            "tribunais": [
                "tjes": true,
                "tjma": true,
                "tjmg": false
            ]    
        },
        {
            "nome": "processos-nao-protocolados",
            "codigo": "IV002CP",
            "descricao": "numero total de processos nao protocolados.",
            "aspecto":"completude",
            "caminho": "completude/IV002CP.sql",
            "filename": "IV002CP.sql",
            "cron": "0 0 * * *",
            "count_only": false,
            "tribunais": [
                "tjes": true,
                "tjma": true,
                "tjmg": false
            ]    
        }
        
    ]
}
```

- **`nome`**: **String** Nome único do item de verificação, seŕa utilizado como nome da métrica.
- **`codigo`**: **String** Código do item, é o nome do arquivo sem a extensão .sql 
- **`descricao`**: **String** Breve descrição do item.
- **`aspecto`**: **String** Descreve o aspécto de qualidade.
- **`caminho`**: **String** É o caminho do arquivo no repositorio.
- **`filename`**: **String** É o nome do arquivo com extensão.
- **`cron`**: **String** Cron expression válida.
- **`apenas_quantitativa`**: **Boolean** Indica se a consulta será apenas quantitativa
- **`Tribunais`**: **Objeto**: Mapeia os tribunais que devem ser considerados para a execução do item. Os tribunais são identificados por siglas e um valor booleano indica se aquele tribunal deve ser incluído (true) ou não (false).

## ✅ Boas Práticas

- Utilize **nomes descritivos** para as classificações e os itens.
- Mantenha o **formato do JSON consistente** em todos os itens.
- Sempre **valide a consulta SQL** antes de adicioná-la ao repositório.
- Faça commits organizados e descreva claramente as mudanças no repositório.

Seguindo essas diretrizes, garantimos um repositório bem estruturado, facilitando a colaboração e a manutenção a longo prazo. 🚀


## 📝 TO:DO

- [ ] Usar o GitHub Actions para construir um validador das consultas e dos jsons.
