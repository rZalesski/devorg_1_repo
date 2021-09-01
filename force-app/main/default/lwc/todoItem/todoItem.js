import { LightningElement, api, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import TODO_SELECTED_CHANNEL from '@salesforce/messageChannel/Todo_Selected__c';
import { NavigationMixin } from 'lightning/navigation';
import { deleteRecord } from 'lightning/uiRecordApi';

export default class TodoItem extends NavigationMixin(LightningElement) {
    @wire(MessageContext)
    messageContext;
    @api 
    todo;
    renderedCallback(){
        this.template.querySelector("lightning-layout").style.backgroundColor = 
        this.todo.Priority__c === "High" ? "lightpink" : 
        this.todo.Priority__c === "Medium" ? "khaki" :
        this.todo.Priority__c === "Low" ? "lightgreen" : "lightgrey";
    }
    handleClick(event){
        event.preventDefault();
        this.dispatchEvent(new CustomEvent('selectitem', {
            detail: this.todo.Id
        }));
        const payload = { selectedTodo : {...this.todo}};
        publish(this.messageContext, TODO_SELECTED_CHANNEL, payload);
    }
    goToEdit(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.todo.Id,
                objectApiName: 'Todo__c',
                actionName: 'edit'
            }
        });
    }
    deleteTodo(){
        const recordId = this.todo.Id;
        deleteRecord(recordId).then(()=>{
            this.dispatchEvent(new CustomEvent('deleteitem', {
                detail: recordId
            }));
        });
    }
}