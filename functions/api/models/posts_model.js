const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class PostModel {
    constructor() {
        if (this.instance) return this.instance;
        PostModel.instance = this;
    }

    get() {
        return database.getList("posts");
    }

    getById(id) {
        return database.get("posts", id);
    }

    create(post) {
        return database.create("posts", post);
    }

    setId(post) {
        return database.setId("posts", post.id, post);
    }

    delete(id) {
        return database.delete("posts", id);
    }

    update(id, post) {
        return database.set("posts", id, post);
    }
}

module.exports = new PostModel();
