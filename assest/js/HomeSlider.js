
const imgPosition = document.querySelectorAll(".aspect-radio-169 img")
const imgContainer = document.querySelector('.aspect-radio-169')
const dotItem = document.querySelectorAll(".dot")
let imgNumber = imgPosition.length
let index = 0
// console.log(imgPosition)
imgPosition.forEach(function (image, index) {
    image.style.left = index * 100 + "%"
    dotItem[index].addEventListener("click", function () {
        slider(index)
    })
})

function imgSlide() {
    index++;
    console.log(index)
    if (index >= imgNumber) {
        index = 0
    }
    slider(index)
}
function slider(index) {
    imgContainer.style.left = "-" + index * 100 + "%"
    const dotActive = document.querySelector('.active')
    dotActive.classList.remove("active")
    dotItem[index].classList.add("active")
}

setInterval(imgSlide, 5000)


