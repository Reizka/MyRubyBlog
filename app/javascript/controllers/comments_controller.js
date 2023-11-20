import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    //initialize(){}
    //connect() {}

    toggleForm(event){
        console.log("CLICKED THE COMMENT EDIT BUTTON");
        event.preventDefault();
        event.stopPropagation();
        const formID = event.params["form"];
        const bodyID = event.params["body"];
        const form = document.getElementById(formID);
        form.classList.toggle("d-none");

    }
}