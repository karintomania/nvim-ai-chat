# NeoVim AI Chat
NeoVim AI chat is a NeoVim plugin to call OpenAI api from NeoVim.

![preview of neovim-ai-chat](https://raw.githubusercontent.com/karintomania/nvim-ai-chat/main/images/demo.gif)

## Prerequisites
You need an api token for OpenAI.

## Getting Started
install the plugin with Plug
```
Plug 'karintomania/nvim-ai-chat'
```

## Config
Include the configuration like below in your init.vim.
This example allow you to use ":Chat" command to start a chat with ChatGPT.
```
lua << EOF
require("nvim-ai-chat").setup({
	token = '<YOUR API TOKEN>', -- access token of open ai
	model = 'gpt-3.5-turbo', -- the model to use
})
EOF

" Exposes the plugin's functions to use as a ":Chat" command.
command! Chat lua require("nvim-ai-chat").ask()
```

