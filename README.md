# NeoVim AI Chat
NeoVim plugin to talk to open ai api (https://api.openai.com/v1/completions) from NeoVim.

![preview of neovim-ai-chat](https://raw.githubusercontent.com/karintomania/nvim-ai-chat/main/images/demo.gif)

## Getting Started
install the plugin with Plug
```
Plug 'karintomania/nvim-ai-chat'
```

## Config
The configuration for this plugin looks like below.
You need an api token for OpenAI.
```
lua << EOF
require("nvim-ai-chat").setup({
	token = '<YOUR API TOKEN>', -- access token of open ai
	model = 'gpt-3.5-turbo', -- the model to use
})
EOF

" You can call the api with command ":Chat <your question>"
command! -nargs=1 Chat lua require("nvim-ai-chat").chat(<q-args>)

" You can call the command with ":'<,'>Vchat" or "":'<,'>Vchat your_question_here" in line select mode
command! -range -nargs=? Vchat lua require("nvim-ai-chat").chatSelection(<line1>, <line2>, <q-args>)
```

