# Discoteca-banco-dados
🎶 Discoteca DB  Sistema de catalogação musical com:  ✅ 50 discos (10/gravadora)  ✅ 30 artistas (solo/banda/dupla)  ✅ 7-10 músicas/disco  🛠 MySQL + BrModelo  Desenvolvido no SENAI.
OBS: se o código não funcionar é porque está muito extenso, tendo que repartir em três diferentes arquivos ou no SQL EM CINCO PARTES:
Parte 1: Criação do Banco e Estrutura Básica
Parte 2: Tabelas Dependentes com Constraints Simples
Parte 3: Inserção de Dados Básicos
Parte 4: Inserção de Artistas
Parte 5: Triggers para Validação


# 🎶 Sistema de Catalogação de Discoteca

Projeto de banco de dados para gerenciar acervo de discos, artistas, músicas e gravadoras, desenvolvido como atividade do SENAI.

## 🔍 Resumo do Projeto
- **Objetivo**: Catalogar discos com artistas, músicas e gravadoras.
- **Regras de Negócio**:
  - Discos devem ter entre 7-10 músicas.
  - Artistas podem ser solo, bandas, duplas ou concertos.
  - Gravadoras podem existir sem discos associados.

## 🛠 Tecnologias Usadas
<p align="left">
  <img src="https://e-tinet.com/wp-content/uploads/2018/10/MySQL-banco-de-dados-linux-1024x512.png" width="100" title="MySQL">
  <img src="https://franciscochaves.com.br/assets/img/blog/2020/01/logo-tux-brmodelo.png" width="100" title="BrModelo">
  <img src="https://portal.fiero.org.br/storage/noticia/vg3k6ntgebURHbSsvwlaPt9qy8UvSvqfIeOnod2C.png" width="100" title="SENAI">
</p>

## 📚 Documentação
- **Modelo Conceitual**: [MER.md](docs/MER.md)
- **DER Visual**: ![DER] 
- **Scripts SQL**: 
  - [Modelo Lógico](scripts/01_modelo_logico.sql)
  - [Banco Físico](scripts/02_modelo_fisico.sql)
  - [Carga de Dados](scripts/03_carga_dados.sql)

## 📌 Como Usar
1. Execute o script `02_modelo_fisico.sql` no MySQL.
2. Popule o BD com `03_carga_dados.sql`.
3. Consulte os dados com:
   ```sql
   SELECT * FROM Disco WHERE id_genero = 1; -- Todos os discos de Rock

📞 Contato
Nome: Marcos Vinicius da Cunha Rocha

Email: marcosviniciusdacunharocha6@gmail.com

LinkedIn: https://www.linkedin.com/in/marcos-vinicius-9b34382b9/

Whatsapp: 61 99116-1843
