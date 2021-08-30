import { LightningElement } from 'lwc';
export default class TodoList extends LightningElement {
    todos = '';
    selectedTodo = '';
    handleSelect(event){
        this.selectedTodo = this.todos.find(
            (todo) => todo.Id === event.detail
        );      
    }
    handleRefresh(event){
        this.todos = event.detail;
    }
}