const { expect } = require("chai");
const {add} = require("../src");

describe("add", () => {
    it("verifies 1 + 1", () => {
        expect(add(1,1)).to.equal(2);
    })
})