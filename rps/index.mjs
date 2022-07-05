import { loadStdlib } from '@reach-sh/stdlib';
import * as backend from './build/index.main.mjs';//import contract ABI

const stdlib = loadStdlib();
const startingBalance = stdlib.parseCurrency(100);//define starting balance 
const accAlice = await stdlib.newTestAccount(startingBalance);//assign starting balance to each account 
const accBob = await stdlib.newTestAccount(startingBalance);

const ctcAlice =  accAlice.contract(backend);//set alice as the deployer of the contract
const ctcBob = accBob.contract(backend, ctcAlice.getInfo());// Bob attaches to alices deployed contract

const HAND = ['rock', 'paper', 'scissors'];
const OUTCOME = ['BOB WINS', 'DRAW', 'Alice wins'];

const Player = (Who) => ({
    getHand: () => {
        const hand = Math.floor(Math.random() * 3)
        console.log(`${Who} played ${HAND[hand]}`);
        return hand;
    },
    seeOutcome: (outcome) => {
        console.log(`${Who} saw the outcome ${OUTCOME}`)
    },
});

await Promise.all([// fetches from interact interface defined in the rsh smart contract
    ctcAlice.p.Alice({//interact object definition
        ...Player('Alice'),
    }),
    ctcBob.p.Bob({
        ...Player('Bob'),
    }),
]);