import { LightningElement, track, wire } from 'lwc';
import getTodosByName from '@salesforce/apex/TodosHandler.getTodosByName';
const DELAY = 300;
export default class TodoSearchBar extends LightningElement {
    key = '';

    // @wire(getTodosByName, {key : '$key'}) 
    // todos;
    //todosf(error, data){
    //   dispatch event here
    //}
    handleKeyChange(event){
        const key = event.target.value;
        window.clearTimeout(this.delayTimeout);
        this.delayTimeout = 
        setTimeout(()=>{
            this.key = key;
            // this.dispatchEvent(new CustomEvent('refreshsearch', {
            //         detail : this.todos.data
            //         }));
            getTodosByName({key : this.key}).then((result)=>{
                this.dispatchEvent(new CustomEvent('refreshsearch', {
                    detail : [...result]
                }));
           })
        }, DELAY);
        
    }
}
