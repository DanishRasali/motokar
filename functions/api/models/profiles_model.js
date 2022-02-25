const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class ProfileModel {
    constructor() {
        if (this.instance) return this.instance;
        ProfileModel.instance = this;
    }

    get() {
        return database.getList("profiles");
    }

    getById(id) {
        return database.get("profiles", id);
    }

    create(profile) {
        return database.create("profiles", profile);
    }

    setId(profile) {
        return database.setId("profiles", profile.id, profile);
    }

    delete(id) {
        return database.delete("profiles", id);
    }

    update(id, profile) {
        return database.set("profiles", id, profile);
    }
}

module.exports = new ProfileModel();
