# NeoVim AI Chat
NeoVim AI chat is a NeoVim plugin to call OpenAI api from NeoVim.

![preview of neovim-ai-chat](https://github.com/karintomania/nvim-ai-chat/assets/19652340/27634a64-75d1-40d6-b05e-561f37e5ecce)

## Prerequisites
- api token for OpenAI.
- curl command installed on your machine

## Getting Started
install the plugin with Plug
```
Plug 'karintomania/nvim-ai-chat'
```

## Config
Include the configuration like below in your init.vim.
This example allow you to use ":Chat" command to start a chat and ask a question.
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

## How to use
Using NeoVim AI Chat is quite simple and the screenshot on top of this page explains almost everything.

Running ":Chat" command opens two windows. The one to display the chat and the other one to type your question.
Once you input the question into the bottom window, you can run ":Chat" command again. The answer will appear in the chat window.
