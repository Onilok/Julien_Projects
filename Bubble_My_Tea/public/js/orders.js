var data = [{
    name: "Matcha",
    url: "medias/bubbletea1.jpeg",
    price: "8,30€",
    description: "Discover our new bubble tea matcha flavour",
    id: 1,

},
{
    name: "Deerioca",
    url: "medias/bubbletea2.jpeg",
    price: "8,30€",
    description: "Discover our new bubble tea deerioca flavour",
    id: 2,

},
{
    name: "Blueberry",
    url: "medias/bubbletea3.jpeg",
    price: "7,30€",
    description: "Discover our new bubble tea deerioca flavour",
    id: 3,

},{
    name: "Mango - Passion fruit",
    url: "medias/bubbletea4.jpeg",
    price: "8,00€",
    description: "Discover our new bubble tea deerioca flavour",
    id: 4,

},
{
    name: "Strawberry",
    url: "medias/bubbletea5.jpeg",
    price: "8,00€",
    description: "Discover our new bubble tea deerioca flavour",
    id: 5,

},
{
    name: "Taro",
    url: "medias/bubbletea6.jpeg",
    price: "7,30€",
    description: "Discover our new bubble tea deerioca flavour",
    id: 6,

}]



function openModal(id){

    document.getElementById('modal').style.display="block"
}
function closeModal(){
    document.getElementById('modal').style.display="none"
}

var bubbletealist = data.map(function(item) {

return `
        <div class="box" id=${item.id}>
            <div class="box-top">
                <img class="box-image" src="${item.url}" alt="${item.name}">
                <div class="title-flex">
                    <h3 class="box-title">${item.name}</h3>
                    <p class="user-follow-info">${item.price}</p>
                </div>
                <p class="description">${item.description}</p>
            </div>
            <button onClick="openModal(${item.id})" class="button" value = "boutton">Add to cart</button>
        </div>`;
        
}) 

//getCommand('${item.name} ${item.price}')

document.getElementById("bubbleteawrap").innerHTML= bubbletealist.join("")

var timeout;

$('#cart').on({
    mouseenter: function() {
        $('#cart-dropdown').show();
    },
    mouseleave: function() {
        timeout = setTimeout(function() {
            $('#cart-dropdown').hide();
        }, 200);
    }
});

// laisse le contenu ouvert à son survol
// le cache quand la souris sort
$('#cart-dropdown').on({
    mouseenter: function() {
        clearTimeout(timeout);
    },
    mouseleave: function() {
        $('#cart-dropdown').hide();
    }
});

