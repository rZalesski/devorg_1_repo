import { LightningElement } from 'lwc';

export default class TodoList extends LightningElement {
    todos = '';
    selectedTodo = '';
    modalOpened = false;

    handleSelect(event){
        this.selectedTodo = this.todos.find(
            (todo) => todo.Id === event.detail
        );      
    }
    handleRefresh(event){
        this.todos = event.detail;
    }
    handleDelete(event){
        this.todos = this.todos.filter(
            (item) => item.Id !== event.detail
        );
    }
    openCreationModal(){
        this.modalOpened = true;
    }
    closeModal(){
        this.modalOpened = false;
    }
}

