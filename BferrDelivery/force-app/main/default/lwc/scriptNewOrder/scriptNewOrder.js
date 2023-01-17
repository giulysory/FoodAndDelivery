import { LightningElement, track } from 'lwc';
import newOrder from '@salesforce/apex/CreateOrder.newOrder';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LightOrder extends LightningElement {
    
    @track AccountId;
    @track ShipToContactId;
    @track Status;
    @track EffectiveDate;
    @track Product;

    handleAccountId(event){
        this.AccountId=event.target.value;
    }

    handleShipTo(event){
        this.ShipToContactId=event.target.value;
    }

    handleStatus(event){
        this.Status=event.target.value;
    }

    handleDate(event){
        this.EffectiveDate=event.target.value;
    }
    handleProduct(event){
        this.Product=event.target.value;
    }


    handleClick(){
        newOrder({acct : this.AccountId, ship : this.ShipToContactId, state : this.Status, day : this.EffectiveDate, Prod :this.Product})
        .then(result => {
            this.message = result;
            this.error = undefined;
            if(this.message !== undefined) {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Order created Succesfully',
                        variant: 'success',
                    }),
                );
            }
            
            console.log(JSON.stringify(result));
            console.log("result", this.message);
        })
        .catch(error => {
            this.message = undefined;
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Failed to Insert order',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
            console.log("error", JSON.stringify(this.error));
        });
    };
}