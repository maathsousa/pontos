# Ponto — React + Firebase

Controle pessoal de horas, otimizado para celular. Firebase Authentication cuida das contas e Cloud Firestore armazena jornada e marcações. A aplicação pode ser hospedada na Vercel.

## Configurar Firebase

1. Acesse [Firebase Console](https://console.firebase.google.com/) e crie um projeto.
2. Em **Authentication → Sign-in method**, habilite **E-mail/senha**.
3. Em **Firestore Database**, crie um banco de dados (produção) e escolha a região.
4. No Firestore, abra **Rules**, cole `firestore.rules` e publique as regras. Elas restringem cada usuário ao próprio caminho de dados.
5. Em **Project settings → General → Your apps**, adicione um aplicativo Web (`</>`) e copie a configuração do Firebase.
6. Crie `.env.local` copiando `.env.example` e preencha os valores `VITE_FIREBASE_*` copiados. Não coloque credenciais administrativas ou service account no frontend.

## Rodar localmente

Com Node.js 20.19+ instalado, abra o terminal nesta pasta e rode:

```sh
npm install
npm run dev
```

Abra o endereço que o Vite mostrar (normalmente `http://localhost:5173`). Use **Criar uma conta** na primeira vez.

## Publicar no GitHub e Vercel

1. Envie esta pasta para um repositório GitHub. O `.gitignore` exclui `.env.local`, dependências e o build.
2. Importe o repositório na Vercel. Use `npm run build` como build e `dist` como diretório de saída.
3. Cadastre as variáveis de ambiente `VITE_FIREBASE_API_KEY`, `VITE_FIREBASE_AUTH_DOMAIN`, `VITE_FIREBASE_PROJECT_ID`, `VITE_FIREBASE_STORAGE_BUCKET`, `VITE_FIREBASE_MESSAGING_SENDER_ID` e `VITE_FIREBASE_APP_ID` nas configurações da Vercel e faça deploy.
4. Em Firebase Authentication, adicione o domínio publicado da Vercel aos domínios autorizados.

## Comportamento

- Entrada, saída para almoço, volta e saída são gravadas no caminho privado `users/{uid}/punches`.
- Jornada fica em `users/{uid}/settings/work`.
- A tela permite lançamento manual com data, etapa, horário e observação. Se já houver a etapa, o novo horário a substitui e aparece identificado como manual.
- O navegador solicita localização ao bater ponto. Depois de permitir, normalmente lembra a autorização para aquele navegador e domínio; a permissão não é vinculada à conta Firebase.
- O histórico exporta CSV que o Excel abre. O saldo soma dias com registros e compara o total trabalhado com a jornada diária prevista.

Este é um protótipo pessoal; não inclui painel de RH, trilha imutável de correções ou regras oficiais de folha. Horários são calculados no fuso local do dispositivo.
