public with sharing class SchedulableJobOnAccount implements Schedulable {
    private Boolean flag1;
    private Boolean flag2;
    public SchedulableJobOnAccount(){
        flag1 = true;
        flag2 = true;
    }
    public SchedulableJobOnAccount(Boolean flag1, Boolean flag2){
        this.flag1 = flag1;
        this.flag2 = flag2;
    }
    public void execute(SchedulableContext context){
        Id batch1Id = (
            flag1 ? Database.executeBatch(new BatchableJobOnAccountWithQL()) : null
        );
        Id batch2Id = (
            flag2 ? Database.executeBatch(new BatchableJobOnAccountWithIterable()) : null
        );
    }
}
