jQuery(document).ready(($) => {
    $('.quantity').on('click', '.plus', function(e) {
        let $input = $(this).prev('input.qty');
        let val = parseInt($input.val());
        if (val < 50) {
            $input.val( val+1 ).change();
        }
    });

    $('.quantity').on('click', '.minus', 
        function(e) {
        let $input = $(this).next('input.qty');
        var val = parseInt($input.val());
        if (val > 1) {
            $input.val(val-1).change();
            
        } 
    });
});


const list = []


function getCommand(order, modalInformation) {
    

    const selectedOrder = data.find(item => item.id == order);


    if (selectedOrder) {
        // je vérifie si la commande de mon user est dans la liste de mes produits
        const existingOrderIndex = orderList.findIndex(item => item.id == selectedOrder.id);
         
        if (existingOrderIndex !== -1) {
            // Si ma commande existe alors je met à jour ma user command
            orderList[existingOrderIndex] = { ...selectedOrder, ...modalInformation };
        } else {
            // Sinon, j'ajoute ma user commande dans ma liste que je vais récup
            orderList.push({ ...selectedOrder, ...modalInformation });
        }

        // j'affiche ma user command dans ma page
        console.log(orderList);
    } else {
        console.error("Command not found in data.");
    }

}