import { LightningElement, wire } from 'lwc';
import getTodosByName from '@salesforce/apex/TodosHandler.getTodosByName';
const DELAY = 300;
export default class TodoSearchBar extends LightningElement {
    key = '';

    @wire(getTodosByName, {key : '$key'}) 
    todosFunc({data}){
        if(data){
            this.dispatchEvent(new CustomEvent('refreshsearch', {
                detail : [...data]
            }));
        }
    }
    handleKeyChange(event){
        const key = event.target.value;
        window.clearTimeout(this.delayTimeout);
        this.delayTimeout = 
        setTimeout(()=>{
            this.key = key;
        }, DELAY);
        
    }
}
