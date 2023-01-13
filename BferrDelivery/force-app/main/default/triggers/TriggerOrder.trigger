trigger TriggerOrder on Order (after insert , before update) {
    if (Trigger.isInsert){
    for (Order a : Trigger.new){
        OrderCallout.newOrderCallout(JSON.serialize(a));
    }
    }
    
}