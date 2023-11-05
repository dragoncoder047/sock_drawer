class Foo {
    then(handler) {
        console.log("then called");
        handler("foo resolve value");
    }
}

async function main() {
    var z = new Foo();
    var x = await z;
    console.log("x is " + x);
}
main();
