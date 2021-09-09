import { LightningElement, wire } from 'lwc';
import getTodosByName from '@salesforce/apex/TodosHandler.getTodosByName';

export default class TodoListWithPagination extends LightningElement {
    pageSize = 3;
    pageNum = 1;
    pagesCount = 0;
    hasNext = false;
    hasPrevious = false;
    todosFiltered = [];
    todos = [];
    @wire(getTodosByName, {key : ''})
    todosFunc({data}){
        if(data){
            data.forEach((item)=>{
                this.todos.push(item);
            });
            this.pagesCount = 
            (this.todos.length ? Math.trunc(this.todos.length / this.pageSize) + 
            ((this.todos.length % this.pageSize) ? 1 : 0) : 0);
            this.hasNext = (this.pagesCount > 1);
            for(let i = 0; i < this.pageSize; i++){
                this.todosFiltered.push(this.todos[i]);
            }
        }
    }

    handleNext(){
        this.pageNum += 1;
        this.paginate();
    }
    handlePrevious(){
        this.pageNum -= 1;
        this.paginate();
    }
    paginate(){
        this.hasPrevious = this.pageNum > 1;
        this.hasNext = this.pagesCount > this.pageNum;  
        this.todosFiltered = [];
        for(let i = (this.pageNum - 1) * this.pageSize; 
        (i < this.pageNum * this.pageSize) && (i < this.todos.length); i++){
            this.todosFiltered.push(this.todos[i]);
        }
    }

}