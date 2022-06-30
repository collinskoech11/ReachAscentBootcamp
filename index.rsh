'reach 0.1';// declare reach version used 

const Player = {
    getHand: Fun([], UInt),
    seeOutcome: Fun([UInt], Null),
}// define player and pass in the functions associated with any Player object

export const main = Reach.App(() => {//reach Constructor equivalent 
    const Alice = Participant('Alice', {// defining the player interact interface 
        ...Player,
    });
    const Bob = Participant('Bob', {
        ...Player,
    });
    init();

    Alice.only(() => {
        const handAlice = declassify(interact.getHand())// check if the hand alices local step is legit
    })
    Alice.publish(handAlice);// publish alices picked hand
    commit();

    Bob.only(() => {
        const handBob = declassify(interact.getHand());
    })
    Bob.publish(handBob);

    const outcome = (handAlice + (4 - handBob)) % 3;
    commit();

    each([Alice, Bob], () => {
        interact.seeOutcome(outcome);
    });
    
});


