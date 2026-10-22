
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
