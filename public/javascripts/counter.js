var counter = document.querySelector('.counter');

  const handleCounterClick = (event) => {
    var count = document.querySelector('.dead-women-counter')
    count.textContent = Number(count.textContent) + 1;
  }

  counter.addEventListener('click', handleCounterClick);