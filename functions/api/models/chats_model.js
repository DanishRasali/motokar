const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class ChatModel {
    constructor() {
        if (this.instance) return this.instance;
        ChatModel.instance = this;
    }

    get() {
        return database.getList("chats");
    }

    getById(id) {
        return database.get("chats", id);
    }

    create(chat) {
        return database.create("chats", chat);
    }

    setId(chat) {
        return database.setId("chats", chat.id, chat);
    }

    delete(id) {
        return database.delete("chats", id);
    }

    update(id, chat) {
        return database.set("chats", id, chat); 
    }
}

module.exports = new ChatModel();
