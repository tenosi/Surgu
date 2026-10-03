const mass = [
        {width: 50, height: 40},
        {width: 60, height: 50},
        {width: 70, height: 60},
        {width: 65, height: 70},
        {width: 90, height: 80},
        {width: 50, height: 90},
        {width: 10, height: 50},
        {width: 70, height: 30}
    ];

    const container = document.createElement('div');
    container.id = 'container2';
    for (let i = 0; i < mass.length; i++) {
        const item = mass[i];
        const block = document.createElement('div');
        block.style.width = item.width + 'px';
        block.style.height = item.height + 'px';
        container.appendChild(block);
    } 
    document.body.appendChild(container);