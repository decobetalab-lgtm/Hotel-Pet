
// Banco de dados simulado no LocalStorage
const db = {
    init: function() {
        if (!localStorage.getItem('pets')) {
            localStorage.setItem('pets', JSON.stringify([
                { id: 1, nome: 'Rex', tipo: 'Cachorro', raca: 'Labrador', dono: 'Maria' },
                { id: 2, nome: 'Miau', tipo: 'Gato', raca: 'Siamês', dono: 'João' }
            ]));
        }
        if (!localStorage.getItem('configuracoes')) {
            localStorage.setItem('configuracoes', JSON.stringify({ diaria: 50, vagas: 10 }));
        }
    },
    getPets: function() { return JSON.parse(localStorage.getItem('pets')); },
    getConfig: function() { return JSON.parse(localStorage.getItem('configuracoes')); },
    setConfig: function(config) { localStorage.setItem('configuracoes', JSON.stringify(config)); }
};

document.addEventListener('DOMContentLoaded', () => {
    db.init();
    const path = window.location.pathname;

    // Configurações
    if (path.includes('configuracoes.html')) {
        const config = db.getConfig();
        const inputs = document.querySelectorAll('input[type="number"]');
        if (inputs.length >= 2) {
            inputs[0].value = config.diaria;
            inputs[1].value = config.vagas;
        }
        const form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', (e) => {
                e.preventDefault();
                db.setConfig({
                    diaria: inputs[0].value,
                    vagas: inputs[1].value
                });
                alert('Configurações salvas com sucesso!');
            });
        }
    }

    // Pets (Exemplo de listagem dinâmica)
    if (path.includes('pets.html')) {
        const tbody = document.querySelector('table tbody');
        if (tbody) {
            const pets = db.getPets();
            tbody.innerHTML = ''; // Limpa a tabela estática
            pets.forEach(pet => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${pet.nome}</td>
                    <td>${pet.tipo}</td>
                    <td>${pet.raca}</td>
                    <td>${pet.dono}</td>
                    <td>
                        <a href="pet_visualizar.html">Visualizar</a> |
                        <a href="pet_editar.html">Editar</a>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        }
    }
});
// --- LÓGICA DA TELA DE NOVA RESERVA ---
const inputCheckin = document.getElementById('checkin');
const inputCheckout = document.getElementById('checkout');
const containerTotal = document.querySelector('.total-diarias');

if (inputCheckin && inputCheckout && containerTotal) {
    // Pega o valor da diária salvo nas configurações ou usa 35 como padrão
    const configuracoes = JSON.parse(localStorage.getItem('hotelPetConfig')) || { diaria: 35 };
    const valorDiaria = parseFloat(configuracoes.diaria);
    
    const spanMensagem = containerTotal.querySelector('span');
    const strongValor = containerTotal.querySelector('strong');

    // Atualiza o texto inicial para mostrar a diária atual
    spanMensagem.textContent = `Total de 0 diária(s) × R$ ${valorDiaria.toFixed(2).replace('.', ',')} =`;
    strongValor.textContent = `R$ 0,00`;

    function calcularTotal() {
        const dataEntrada = new Date(inputCheckin.value);
        const dataSaida = new Date(inputCheckout.value);

        if (!isNaN(dataEntrada) && !isNaN(dataSaida) && dataSaida >= dataEntrada) {
            // Calcula a diferença de dias
            const diferencaTempo = dataSaida.getTime() - dataEntrada.getTime();
            let dias = diferencaTempo / (1000 * 3600 * 24);
            
            // Se for no mesmo dia, conta como 1 diária mínima
            if (dias === 0) dias = 1;

            const total = dias * valorDiaria;

            spanMensagem.textContent = `Total de ${dias} diária(s) × R$ ${valorDiaria.toFixed(2).replace('.', ',')} =`;
            strongValor.textContent = `R$ ${total.toFixed(2).replace('.', ',')}`;
        }
    }

    inputCheckin.addEventListener('change', calcularTotal);
    inputCheckout.addEventListener('change', calcularTotal);
}