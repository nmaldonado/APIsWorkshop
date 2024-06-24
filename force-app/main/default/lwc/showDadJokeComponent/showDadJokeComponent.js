import { LightningElement,wire } from 'lwc';
import getDadJoke from '@salesforce/apex/DadJokeController.getDadJoke';

export default class ShowDadJokeComponent extends LightningElement {

    loading = false;
    dadJoke;
    error;

    
    async handleJokes() {
        this.loading = true;
        this.dadJoke='';
        try {
            let response = await getDadJoke();
            this.dadJoke = JSON.parse(response);
            this.loading = false;
            console.log('response',response); 
        } catch (error) {
            console.log('error',error);   
        }
    }


    connectedCallback() {
        this.handleJokes();
    }

    
    handleRefresh() {
        this.handleJokes();
    }
}