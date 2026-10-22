# Nosso Cantinho ❤️ — publicação e backend

## Publicar no GitHub Pages
1. Descompacta o ZIP.
2. Envia `index.html`, `style.css`, `app.js`, `supabase.sql` e `SETUP.md` para a raiz do teu repositório GitHub.
3. No GitHub, abre **Settings → Pages**. Seleciona **Deploy from a branch**, branch `main`, pasta `/(root)` e guarda.
4. Espera alguns minutos e abre `https://TEU-UTILIZADOR.github.io/TEU-REPOSITORIO/`.

## Estado do projeto
A interface, animações, navegação, jogo da velha, gravação local de áudio, fotos e cartas estão preparados. Sem backend, os dados só existem no navegador atual; não aparecem no telemóvel da outra pessoa. O formulário Supabase é uma base de integração, mas a sincronização real requer terminar autenticação, políticas RLS e armazenamento.

## Configurar backend de forma segura
1. Cria um projeto em https://supabase.com/.
2. Abre SQL Editor e executa `supabase.sql`.
3. Ativa **Authentication** e cria um método de login para cada pessoa.
4. Cria uma tabela `room_members` que associe `room_id` a `auth.uid()` e limita a dois membros por sala.
5. Cria políticas RLS em `room_events` para SELECT/INSERT que confirmem que `auth.uid()` é membro da sala. Usa também validação de `kind`, limites de tamanho e ownership.
6. Ativa Realtime para `room_events` e filtra as subscrições por sala autorizada.
7. Para fotos/áudios, usa Supabase Storage com bucket privado e políticas por membro. Guarda no banco só o caminho do ficheiro, não data URLs grandes.
8. Só depois de autenticação e RLS estarem testadas, cola no ícone ⚙ do site a Project URL e a chave pública `anon`/publishable.

**Nunca coloques uma `service_role` key em `app.js`, no GitHub ou no browser.** Uma chave pública não substitui as políticas de segurança. Um link partilhado ou um código de sala não é autenticação privada: pode ser encaminhado a outras pessoas.

## Áudios e fotos
O modo local permite testar gravação e imagens pequenas. O microfone exige permissão do navegador e normalmente HTTPS. Para uso real, envia os ficheiros para Storage privado e aplica limites de tamanho. Não uses este protótipo para dados sensíveis até completares o backend.

## Próximo passo técnico
O SQL fornecido cria a tabela com RLS ativado e não abre leitura/escrita anónima. Isso é intencional. O código de interface não constitui, sozinho, um sistema privado pronto para produção: é necessário implementar o login e as políticas de membros antes de ativar a sincronização entre duas pessoas.
