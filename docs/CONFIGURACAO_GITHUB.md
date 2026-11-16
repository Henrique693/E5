# Configuração obrigatória no GitHub

Este roteiro complementa os arquivos do projeto. Workflows podem ser versionados no repositório, mas regras de proteção, colaboradores e revisores dos ambientes são configurações administrativas feitas no GitHub.

Repositório: <https://github.com/Henrique693/E5>

## 1. Publicar os arquivos preparados

1. Faça uma cópia de segurança do repositório local.
2. Extraia o pacote atualizado sobre o clone local do repositório, substituindo os arquivos antigos e preservando a pasta `.git` do clone.
3. Confira se a raiz contém `.github/workflows/ci.yml`, `.github/workflows/cd.yml`, `docs/` e `gerador_qr/`.
4. Crie uma branch de trabalho, por exemplo `feature/gcs-ci-cd`.
5. Faça commit e push dessa branch. Não envie diretamente para `main`.
6. Abra um Pull Request para `main`.

O repositório atual já tinha a pasta `.idea/` versionada. Para removê-la do controle de versão sem apagar a cópia local, execute na raiz do clone: `git rm -r --cached .idea`. O `.gitignore` atualizado evitará que ela volte a ser adicionada. Só remova outras pastas com `git rm --cached` se `git ls-files` confirmar que também estão versionadas.

## 2. Adicionar o par de revisão com permissão Write

1. Abra **Settings → Collaborators** (ou **Collaborators and teams**).
2. Selecione **Add people**.
3. Informe o usuário GitHub do colega que fará a revisão.
4. Conceda a permissão **Write** e envie o convite.
5. Peça ao colega para aceitar o convite.

O nome de usuário do colega deve ser confirmado pelo proprietário do projeto; não há um usuário fictício configurado nos arquivos.

## 3. Proteger a branch `main`

Abra **Settings → Branches → Add branch protection rule** (ou a tela equivalente de regras de branch) e use:

- Branch name pattern: `main`.
- Ativar **Require a pull request before merging**.
- Exigir pelo menos **1 approval**.
- Ativar **Dismiss stale pull request approvals when new commits are pushed**.
- Ativar **Require approval of the most recent reviewable push**, quando disponível.
- Ativar **Require status checks to pass before merging** e selecionar o check do job de CI (normalmente exibido como **CI / quality-and-build**; escolha o nome exato que aparecer depois da primeira execução do workflow).
- Ativar **Do not allow bypassing the above settings** / aplicar as regras também aos administradores, quando a opção estiver disponível.
- Não permitir force pushes nem exclusão da branch protegida.

Salve a regra. A proteção do GitHub só estará comprovada após ser salva e testada no repositório remoto.

### Evidência da recusa de push direto

Depois que a proteção estiver ativa, faça um commit de teste em uma branch temporária e tente enviar esse commit para `main`:

```bash
git switch -c teste-bloqueio-main
git commit --allow-empty -m "test: verificar protecao da main"
git push origin HEAD:main
```

O GitHub deverá rejeitar o push devido à regra de proteção. Guarde uma captura de tela do terminal mostrando a rejeição. Depois, descarte a branch local de teste (`git switch main` e `git branch -D teste-bloqueio-main`), se não precisar dela.

Não faça esse teste antes de salvar a regra de proteção.

## 4. Criar os GitHub Environments

Abra **Settings → Environments**.

### `staging`

1. Crie um environment com o nome exato `staging`.
2. Não é necessário adicionar aprovador obrigatório para este ambiente, conforme o fluxo definido no projeto.

O workflow `CD` usa esse environment para validar se o APK e o build Web foram gerados e estão disponíveis. Como o app não possui servidor/backend próprio, esta etapa é uma validação dos artefatos, não uma publicação em infraestrutura externa.

### `production`

1. Crie um environment com o nome exato `production`.
2. Em **Required reviewers**, adicione a conta do proprietário do repositório (`Henrique693`), que representa o responsável indicado no plano.
3. Não habilite **Prevent self-review** caso o proprietário precise aprovar uma implantação que ele próprio iniciou.
4. Salve as regras.

O job `publish-production` ficará aguardando essa aprovação antes de publicar uma GitHub Release com o APK e os arquivos Web que passaram pela validação de staging.

## 5. Confirmar a execução dos workflows

1. Abra **Actions** no repositório.
2. Faça merge de um Pull Request aprovado em `main`.
3. Confirme que `CI` concluiu formatação, análise, testes e builds.
4. Confirme que `CD` iniciou e passou pelo job `staging-validation`.
5. Confirme que `publish-production` ficou aguardando aprovação no environment `production`.
6. Aprove a implantação com a conta revisora configurada e confirme a criação da GitHub Release.

A etapa CD só é disparada depois de uma execução bem-sucedida da CI em push na branch `main`.

## 6. Evidências para entregar na avaliação

Guarde capturas de tela legíveis de:

- Repositório público, com a estrutura de pastas e o plano GCS em `docs/`.
- Regra de proteção da branch `main`, mostrando PR obrigatório e uma aprovação.
- Terminal mostrando a recusa do push direto para `main`.
- Tela de colaboradores, mostrando o colega com permissão **Write** e convite aceito.
- Environment `staging` criado.
- Environment `production` com `Henrique693` em **Required reviewers**.
- Pull Request com aprovação do colega.
- Execuções bem-sucedidas da CI e do CD, incluindo a aprovação de produção e a Release.

## 7. Limites e estado desta entrega

Os arquivos de CI/CD e a documentação estão preparados no projeto fornecido. Eles não criam automaticamente colaboradores, proteções de branch, environments ou evidências no GitHub. Esses passos dependem de acesso de administrador ao repositório e devem ser realizados e comprovados pelo proprietário.
