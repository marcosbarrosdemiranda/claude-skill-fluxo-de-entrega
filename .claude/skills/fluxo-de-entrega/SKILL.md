---
name: fluxo-de-entrega
description: Use SEMPRE ao terminar qualquer solicitação que tenha alterado arquivos do projeto (implementação, correção, ajuste, refatoração, configuração, documentação), mesmo que o trabalho ainda vá ter alterações depois. Use também quando o usuário disser "finaliza", "salva", "salvar memória", "commita", "sobe", "encerrar sessão", "deixa recado", "lembra a próxima sessão", "o que as outras sessões fizeram", e sempre que houver referência a trabalho anterior. Executa automaticamente o fluxo completo de documentação, git pull --rebase, commit convencional, push para dev, consulta de produção e salvamento compactado no Obsidian.
---

# Fluxo de Entrega e Memória Integrada ao Obsidian

Esta skill gerencia o ciclo completo de entrega de tarefas, sincronização entre sessões e persistência de memória estruturada no Obsidian (`VAULT_MEMORIA`).

## ORDEM OBRIGATÓRIA DOS PASSOS

1. **DOCUMENTAR**
   - Atualizar a documentação afetada (README.md, comentários, CHANGELOG.md com data e descrição).
   - Se não houver documentação a alterar, registrar ao menos no CHANGELOG.md.

2. **COMMIT & SINCRONIZAÇÃO**
   - Rodar testes (se houver). Se falhar, parar.
   - Verificar ausência de segredos (`.env`, tokens, senhas).
   - Executar `git pull --rebase` na branch `dev`. Se houver conflito, parar e mostrar os arquivos (nunca descartar alteração de outra sessão).
   - Fazer commit de tudo alterado usando **Conventional Commits** (feat, fix, docs, refactor, chore...), mensagem clara em português (indicar `- parcial` se for o caso).

3. **PUSH PARA O GITHUB**
   - Push para a branch `dev` (criar se não existir). Nunca usar `push --force`.

4. **PERGUNTAR SOBRE PRODUÇÃO**
   - Perguntar: *"Deseja subir esta versão para produção?"*
   - Se **sim**: rodar testes, merge de `dev` para `main` e deploy.
   - Se **não**: avançar para o passo 5.

5. **SALVAR HISTÓRICO NO OBSIDIAN (Compactação & Sincronização)**
   - **Histórico Detalhado (`historico/AAAA-MM-DD.md`)**:
     Frontmatter YAML no topo (data, projeto, tags `#feat`|`#fix`|`#config`|`#decisao`, commits).
     Registros com formato `## HH:MM - Título #tag`, Pedido, Feito, Decisões, Arquivos, Commit, Produção, Problemas, Pendências. Usar links `[[ ]]` para alimentar o grafo.
   - **Estado Compactado (`ESTADO.md`)**:
     Reescrever o ESTADO.md do projeto (máximo 60 linhas, estilo telegráfico):
     - Estado atual
     - Últimas 10 alterações (1 linha cada: data, resumo, hash)
     - Decisões vigentes
     - Pendências abertas
   - **Índice Global (`INDICE.md`)**:
     Adicionar 1 linha no `Claude/INDICE.md` global: `"AAAA-MM-DD HH:MM [projeto] resumo curto"`. Manter apenas 30 dias (mais antigos vão para `INDICE-ARQUIVO.md`).
   - **Sessões Ativas & Recados**:
     Atualizar `SESSOES-ATIVAS.md` e `RECADOS.md`. Ao encerrar sessão, remover o registro ativo.

## RESUMO FINAL
Mostrar um resumo de uma linha por passo:
- Documentado: [ok]
- Sincronizado/Commit: [ok/hash]
- Push: [ok/dev]
- Produção: [sim/não]
- Histórico Obsidian: [ok]
