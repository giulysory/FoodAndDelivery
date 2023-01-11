trigger TriggerOrder on Order (after insert) {
    for (Order a : Trigger.new){
        OrderCallout.newOrderCallout(JSON.serialize(a));
    }
}