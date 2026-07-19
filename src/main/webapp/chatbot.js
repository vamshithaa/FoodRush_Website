(function () {
    // Inject styles
    const style = document.createElement('style');
    style.textContent = `
        #chatbot-toggle-btn {
            position: fixed; bottom: 20px; right: 20px;
            width: 60px; height: 60px; border-radius: 50%;
            background: #ff4b2b; color: white; border: none;
            font-size: 26px; cursor: pointer; z-index: 9999;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }
        #chatbot-box {
            position: fixed; bottom: 90px; right: 20px;
            width: 320px; height: 420px; background: white;
            border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            display: none; flex-direction: column; overflow: hidden;
            font-family: Arial, sans-serif; z-index: 9999;
        }
        #chatbot-header {
            background: #ff4b2b; color: white; padding: 12px 14px;
            font-weight: bold;
            display: flex; align-items: center; justify-content: space-between;
        }
        #chatbot-close-btn {
            background: none; border: none; color: white;
            font-size: 20px; line-height: 1; cursor: pointer;
            padding: 4px; margin: -4px;
            display: flex; align-items: center; justify-content: center;
            opacity: 0.9;
        }
        #chatbot-close-btn:hover { opacity: 1; }
        #chatbot-messages {
            flex: 1; padding: 10px; overflow-y: auto; font-size: 14px;
        }
        .chat-msg { margin: 6px 0; padding: 8px 12px; border-radius: 10px; max-width: 80%; }
        .chat-msg.user { background: #ff4b2b; color: white; margin-left: auto; }
        .chat-msg.bot { background: #f1f1f1; color: #333; }
        #chatbot-input-area { display: flex; border-top: 1px solid #ddd; }
        #chatbot-input {
            flex: 1; border: none; padding: 10px; font-size: 14px; outline: none;
        }
        #chatbot-send-btn {
            background: #ff4b2b; color: white; border: none;
            padding: 0 16px; cursor: pointer;
        }
    `;
    document.head.appendChild(style);

    // Inject HTML
    const container = document.createElement('div');
    container.innerHTML = `
        <button id="chatbot-toggle-btn">💬</button>
        <div id="chatbot-box">
            <div id="chatbot-header">
                <span>FoodRush Assistant</span>
                <button id="chatbot-close-btn" aria-label="Close chat" title="Close">&times;</button>
            </div>
            <div id="chatbot-messages"></div>
            <div id="chatbot-input-area">
                <input id="chatbot-input" type="text" placeholder="Ask me anything..." />
                <button id="chatbot-send-btn">➤</button>
            </div>
        </div>
    `;
    document.body.appendChild(container);

    const toggleBtn = document.getElementById('chatbot-toggle-btn');
    const box = document.getElementById('chatbot-box');
    const closeBtn = document.getElementById('chatbot-close-btn');
    const messages = document.getElementById('chatbot-messages');
    const input = document.getElementById('chatbot-input');
    const sendBtn = document.getElementById('chatbot-send-btn');

    toggleBtn.addEventListener('click', () => {
        box.style.display = (box.style.display === 'flex') ? 'none' : 'flex';
        if (box.style.display === 'flex' && messages.children.length === 0) {
            addMessage("Hi! I'm your FoodRush assistant. Ask me about menu items, orders, or anything else!", 'bot');
        }
    });

    closeBtn.addEventListener('click', () => {
        box.style.display = 'none';
    });

    function addMessage(text, sender) {
        const div = document.createElement('div');
        div.className = 'chat-msg ' + sender;
        div.textContent = text;
        messages.appendChild(div);
        messages.scrollTop = messages.scrollHeight;
    }

    function sendMessage() {
        const text = input.value.trim();
        if (!text) return;
        addMessage(text, 'user');
        input.value = '';
        addMessage('Typing...', 'bot');

        fetch('chatbotServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'message=' + encodeURIComponent(text)
        })
        .then(res => res.json())
        .then(data => {
            messages.removeChild(messages.lastChild); // remove "Typing..."
            addMessage(data.reply, 'bot');
        })
        .catch(() => {
            messages.removeChild(messages.lastChild);
            addMessage("Sorry, something went wrong.", 'bot');
        });
    }

    sendBtn.addEventListener('click', sendMessage);
    input.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') sendMessage();
    });
})();