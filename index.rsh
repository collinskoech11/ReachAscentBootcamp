'reach 0.1';

const Player = {
    getHand: Fun([], UInt),
    seeOutcome: Fun([UInt], Null),
}// define player and the functions associated

export const main = Reach.App(() => {
    const Alice = Participant('Alice', {// defining the player
        ...Player,
    });
    const Bob = Participant('Bob', {
        ...Player,
    });
    init();

    Alice.only(() => {
        const handAlice = declassify(interact.getHand())
    })
    Alice.publish(handAlice);
    commit();

    Bob.only(() => {
        const handBob = declassify(interact.getHand());
    })
    Bob.publish(handBob);

    const outcome = (handAlice = declassify)
});

