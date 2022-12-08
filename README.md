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
	maxLength = 500, -- maximum length of the answer, default 300
	temperature = 0 -- sampling temperature, default 0.1
})
EOF

" You can call the api with command ":Chat <your question>"
command! -nargs=1 Chat lua require("nvim-ai-chat").chat(<q-args>)

```

