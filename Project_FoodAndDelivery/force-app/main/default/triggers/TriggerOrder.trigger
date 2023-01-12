trigger TriggerOrder on Order (after insert) {
    List<Order> ordConfermati = new List<Order>();
    for (Order a : Trigger.new){
        if(a.Status =='Confirmed'){
            ordConfermati.add(a);
        }
    }
    OrderCallout.newOrderCallout(JSON.serialize(ordConfermati));
}