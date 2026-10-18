# SKILL-Memo-Session

Repositório dedicado à configuração e teste da skill **fluxo-de-entrega** do Claude Code, integrando gestão automática de documentação, commits padronizados, push para o GitHub, controle de produção e histórico de sessões via memória persistente por projeto com carregamento automático via hook `SessionStart`.

## Estrutura
- `.claude/skills/fluxo-de-entrega/`: Skill de fluxo de entrega.
- `.claude/scripts/load_memoria.ps1`: Script de carregamento automático de memória na inicialização.
- `.claude/memoria/`: Histórico diário de sessões (`YYYY-MM-DD.md`) e índice geral (`INDICE.md`).
- `CLAUDE.md`: Regras do projeto e gatilho para a skill de entrega.
