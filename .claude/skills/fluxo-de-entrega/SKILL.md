---
name: fluxo-de-entrega
description: Use SEMPRE ao terminar qualquer solicitação que tenha alterado arquivos do projeto (implementação, correção, ajuste, refatoração, configuração, documentação), mesmo que o trabalho ainda vá ter alterações depois. Use também quando o usuário disser "finaliza", "salva", "salvar memória", "commita", "sobe", "encerrar sessão", "deixa recado", "lembra a próxima sessão", e sempre que houver referência a trabalho de sessões anteriores. Executa automaticamente o fluxo completo com git pull --rebase, documentação, commit, push para dev, consulta de produção, histórico global/local, sessões ativas e recados.
---

# Fluxo de Entrega e Comunicação Entre Sessões (Skill Automática)

Esta skill executa o fluxo completo e obrigatório de encerramento de tarefas, sincronização com outras sessões, commit, push, produção e gestão de memória global e de recados.

## ORDEM OBRIGATÓRIA DOS PASSOS

1. **DOCUMENTAR**
   - Atualizar a documentação afetada (README.md, comentários, CHANGELOG.md com data e descrição).
   - Se não houver impacto em documentação, registrar ao menos no CHANGELOG.md.

2. **SINCRONIZAR ANTES DO COMMIT**
   - Antes do commit, fazer `git pull --rebase` na branch `dev` para incorporar atualizações de outras sessões.
   - Se houver conflito, parar imediatamente e mostrar os arquivos em conflito. Nunca resolver descartando alterações de outra sessão.

3. **COMMIT & TESTES**
   - Verificar testes (se houver). Se falharem, parar e reportar o erro.
   - Verificar ausência de segredos ou dados sensíveis (`.env`, tokens, etc.).
   - Fazer commit de tudo alterado usando **Conventional Commits** (feat, fix, docs, refactor, chore...), mensagem em português. Se for parcial, indicar (ex: `feat(api): rota de sensores - parcial`).
   - Terminar commit com a atribuição exigida.

4. **PUSH PARA O GITHUB**
   - Fazer push para a branch `dev` (criar se não existir). Nunca usar `push --force`.
   - Se falhar, parar e explicar.

5. **PERGUNTAR SOBRE PRODUÇÃO**
   - Perguntar explicitamente ao usuário: *"Deseja subir esta versão para produção?"*
   - Se **sim**: rodar testes, merge de `dev` para `main` e deploy.
   - Se **não**: avançar para o passo 6.

6. **SALVAR HISTÓRICO DA SESSÃO & COMUNICAÇÃO**
   - **Memória Local do Projeto**: `.claude/memoria/AAAA-MM-DD.md` (formato com HH:MM, pedido, feito, decisões, arquivos, commit, produção, problemas, pendências) e atualizar `.claude/memoria/INDICE.md`.
   - **Memória Global**: Gravar linha em `~/.claude/memoria-global/AAAA-MM-DD.md` e `INDICE.md` global no formato: `[nome-do-projeto] HH:MM - resumo`.
   - **Sessões Ativas**: Remover o próprio registro de `.claude/memoria/SESSOES-ATIVAS.md` (limpando também registros inativos há mais de 2 horas).
   - **Recados**: Se houver pendências ou se o usuário pediu para deixar recado, registrar em `.claude/memoria/RECADOS.md`.

## RESUMO FINAL
Ao terminar o fluxo, mostre um resumo de uma linha por passo:
- Sincronizado: [ok]
- Documentado: [ok]
- Commit: [ok/hash]
- Push: [ok/dev]
- Produção: [sim/não]
- Histórico Local & Global: [ok]
