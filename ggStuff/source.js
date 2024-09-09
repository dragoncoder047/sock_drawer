function mystery() {
    var stones = randint(15, 31);
    var misere = 1 - confirm(`This is the game of Nim.\n\nWe start with ${stones} stones.\n\nPress OK to start a normal game (to win, take the last stone)\nor press Cancel to play a misere game (to win, force the other player to take the last stone).`);
    if (confirm("Should the computer play first?")) stones = comp_turn(stones);
    while (stones) stones = one_round(stones);
    function comp_turn(stones) {
        var take = ((stones - misere) % 4) || randint(1, 3);
        stones -= take;
        alert(`The computer takes ${take} stones to leave ${stones} stones.`);
        if (stones == misere) {
            alert("The computer wins!!");
            return 0;
        }
        return stones;
    }
    function one_round(stones) {
        var take, pr = `There are ${stones} stones.\n\nEnter the number of stones to take (1-${Math.min(3, stones)}):`, invalid = false;
        for (; ;) {
            take = prompt(pr);
            if (take == null) return 0;
            if (/^[123]$/.test(take)) {
                take = parseInt(take);
                if (take <= stones) break;
            }
            if (!invalid) {
                invalid = true;
                pr = "Invalid input, try again.\n\n" + pr;
            }
        }
        stones -= take;
        alert(`You take ${take} stones, leaving ${stones}`);
        if (stones == misere) {
            alert("The computer has no choice but to take the last stone -- you win!!");
            return 0;
        } else if (stones == 0) {
            alert("Strange way of losing -- this was a misere game.");
            return 0;
        }
        return comp_turn(stones);
    }
    function randint(lo, hi) {
        return lo + (0 | (Math.random() * (hi - lo)));
    }
}
mystery();
