trigger TriggerOrder on Order (after insert, after update) {
    List<Order> ordConfermati = new List<Order>();

        if(Trigger.isInsert){
            for (Order a : Trigger.new){
                if(a.Status =='Ordine Confermato'){
                    ordConfermati.add(a);
                }
            }
                OrderCallout.newOrderCallout(JSON.serialize(ordConfermati));
        }   
    

                }