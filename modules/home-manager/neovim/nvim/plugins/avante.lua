require("avante_lib").load()
require("avante").setup({
	provider = "gemini",
	rag_service = {
		enabled = false, -- Enables the RAG service
		host_mount = vim.fn.getcwd(), -- Host mount path for the rag service
		provider = "ollama", -- The provider to use for RAG service (e.g. openai or ollama)
		llm_model = "", -- The LLM model to use for RAG service
		embed_model = "", -- The embedding model to use for RAG service
		endpoint = "http://localhost:11434", -- The API endpoint for RAG service
	},
})
