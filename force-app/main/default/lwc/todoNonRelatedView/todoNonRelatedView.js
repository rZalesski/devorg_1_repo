import { LightningElement, track, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import TODO_SELECTED_CHANNEL from '@salesforce/messageChannel/Todo_Selected__c';

export default class TodoNonRelatedView extends LightningElement {
    todo = '';
    subscribtion = null;
    @wire(MessageContext)
    messageContext;
    subscribeToMessageChannel(){
        this.subscribtion = subscribe(
            this.messageContext,
            TODO_SELECTED_CHANNEL,
            (message)=>this.handleMessage(message)
        );
    }
    handleMessage(message){
        this.todo = message.selectedTodo;
    }
    connectedCallback(){
        this.subscribeToMessageChannel();
    }
}