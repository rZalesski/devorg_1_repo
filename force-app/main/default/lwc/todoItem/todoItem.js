import { LightningElement, api } from 'lwc';

export default class TodoItem extends LightningElement {
    @api todo;
    handleClick(event){
        event.preventDefault();
        this.dispatchEvent(new CustomEvent('selectitem', {
            detail: this.todo.Id
        }));
    }
}