<template>
  <body class="clay-bg">
  <header class="bg-white px-4 py-6">
    <div class="container mx-auto flex items-center justify-between">
      <h1 class="text-2xl clay-primary font-serif font-bold" style="font-family: 'Montserrat', sans-serif;">RoomLab</h1>
      <nav>
        <ul class="flex items-center space-x-4">
          <li><a href="#" class="clay-primary font-bold" style="font-family: 'Montserrat', sans-serif;">Home</a></li>
          <li><a href="#nft-collection" class="clay-primary font-bold" style="font-family: 'Montserrat', sans-serif;">Collection</a></li>
          <li><a href="#roadmap" class="clay-primary font-bold" style="font-family: 'Montserrat', sans-serif;">Roadmap</a></li>
          <li><a href="#faq" class="clay-primary font-bold" style="font-family: 'Montserrat', sans-serif;">FAQ</a></li>
          <li><button class="wallet-button clay-button py-2 px-4 rounded">Connect wallet</button></li>
        </ul>
      </nav>
    </div>
  </header>
  <main class="container mx-auto py-6 px-4">
    <section id="mint-nft" class="text-center">
      <h2 class="text-4xl clay-primary mb-4" style="font-family: 'Montserrat', sans-serif;">Mint a NFT</h2>
      <p class="text-2xl clay-primary py-6 px-4" style="font-family: 'Montserrat', sans-serif;">RLAB is a collection of 300 NFTs<br/><br/>Mint yours now</p>
      <button class="clay-button py-2 px-4 rounded">Mint now</button>
    </section>
    <section id="nft-collection" class="flex justify-center py-6 px-4">
      <div class="nft mr-4">
        <img src="1.png" alt="Nom de l'image NFT">
        <p class="text-center clay-secondary">NFT #1</p>
      </div>
      <div class="nft mr-4">
        <img src="13.png" alt="Nom de l'image NFT">
        <p class="text-center clay-secondary">NFT #13</p>
      </div>
      <div class="nft">
        <img src="27.png" alt="Nom de l'image NFT">
        <p class="text-center clay-secondary">NFT #27</p>
      </div>
    </section>
    <section id="roadmap" class="text-center mt-6 py-6 px-4">
      <h2 class="text-2xl clay-primary" style="font-family: 'Montserrat', sans-serif;">Roadmap</h2>
      <ul>
        <li class="clay-secondary">Phase 1 - Préparation du lancement</li>
        <li class="clay-secondary">Phase 2 - Lancement de la vente NFT</li>
        <li class="clay-secondary">Phase 3 - Développement des fonctionnalités supplémentaires</li>
        <li class="clay-secondary">Phase 4 - Lancement des rewards</li>
      </ul>

    </section>
    <section id="faq" class="mt-6 text-center mt-2 py-6 px-4">
      <h2 class="text-2xl clay-primary" style="font-family: 'Montserrat', sans-serif;">FAQ</h2>
      <div class="accordion">
        <div class="accordion-item mt-6">
          <h3 class="accordion-title font-bold" style="font-family: 'Montserrat', sans-serif;">Pourquoi RoomLab se lance dans le web 3 ?</h3>
          <div class="accordion-content">
            <p>En s’engageant dans l’univers web3, RoomLab souhaite transporter sa communauté dans les coulisses de la marque, <br/>et lui faire vivre des expériences uniques, exclusives mais aussi de belles surprises.</p>
          </div>
        </div>
        <div class="accordion-item mt-6">
          <h3 class="accordion-title font-bold" style="font-family: 'Montserrat', sans-serif;">Pourquoi 300 NFTs ?</h3>
          <div class="accordion-content">
            <p>C'est le nombre de point de vente que nous avons en France et nous avons décidé<br/> de créer une collection de 300 NFTs pour unir l'ensemble de nos points de vente.</p>
          </div>
        </div>
        <div class="accordion-item mt-6">
          <h3 class="accordion-title font-bold" style="font-family: 'Montserrat', sans-serif;">Comment les NFTs sont créés ?</h3>
          <div class="accordion-content">
            <p>Nous avons fait appel au talent de SYNEIDO LAB, pour la création du design et de l'écriture du smart contract.<br/>
              La couleur, les murs, les fenêtres et le mobilier sont design sous 3 types de pièces, une de ces pièces est unique et sous 5 exemplaires uniquement !<br/>
              Les traits de rareté sont randomisés grâce à un algorithme pour créer 300 NFTs uniques, entre mobilier moderne et mobilier hanté.
            </p>

          </div>
        </div>
        <div class="accordion-item mt-6">
          <h3 class="accordion-title font-bold" style="font-family: 'Montserrat', sans-serif;">Quelle Blockchain est utilisée ?</h3>
          <div class="accordion-content">
            <p>Les NFT seront mintés sur la blockchain Ethereum. Ethereum est la blockchain la plus utilisée pour les projets NFT et elle dispose de la plus grande communauté de développeurs.<br/>
              De plus, la consommation d’énergie d’Ethereum a été réduite de 99,95% lors de son passage en Proof of Stake.</p>
          </div>
        </div>
        <div class="accordion-item mt-6">
          <h3 class="accordion-title font-bold" style="font-family: 'Montserrat', sans-serif;">Qu'est ce que le mint ?</h3>
          <div class="accordion-content">
            <p>Le mint est le moment de création d'un NFT. Cela correspond au moment où le NFT est inscrit et enregistré sur la blockchain.<br/>
              Littéralement, le mot "mint" en anglais signifie "frapper une pièce de monnaie" et lui conférer sa valeur.</p>
          </div>
        </div>
        <div class="accordion-item mt-6">
          <h3 class="accordion-title font-bold" style="font-family: 'Montserrat', sans-serif;">Quand aura lieu le mint ?</h3>
          <div class="accordion-content">
            <p>Le mint se déroulera le 31 octobre 2023. L’ouverture publique des achats aura lieu à 18h.</p>
          </div>
        </div>
        <div class="accordion-item mt-6">
          <h3 class="accordion-title font-bold" style="font-family: 'Montserrat', sans-serif;">Pourquoi faire l’acquisition d’un NFT RLAB ?</h3>
          <div class="accordion-content">
            <p>Le premier NFT RLAB donne accès à l’univers RoomLab, c’est un pass pour devenir un “insider” des coulisses de la marque.<br/><br/>
              Une ambition long terme signifie des utilités long terme et les détenteurs de NFT RLAB peuvent s’attendre à des expériences exclusives,<br/>
              auparavant inaccessibles au grand public : rencontre avec des designers mobilier, visite de la manufacture, inauguration des futurs meuble, invitation VIP pour Roland Garros, réduction lors des achats en ligne et pour les plus chanceux un mobilier offert.<br/><br/>
              Le NFT offrira aussi la possibilité de co-créer des objets de merchandising par la première collection de NFT et réservés exclusivement à la communauté web3.<br/><br/>
              Enfin chaque détenteur du NFT RLAB sera privilégié sur l’ensemble de la roadmap 2023-2024, puisqu’il sera whitelisté pour les prochains drops !
            </p>
          </div>
        </div>
      </div>
      <div class="accordion-item mt-6">
        <h3 class="accordion-title font-bold" style="font-family: 'Montserrat', sans-serif;">Comment acheter un NFT RLAB ?</h3>
        <div class="accordion-content">
          <p class="font-bold" style="font-family: 'Montserrat', sans-serif;">Paiement crypto :</p>
          <p>1. Je me connecte à mon wallet. si je n’ai pas de wallet je peux en créer un très facilement via <a href="https://metamask.io/" class="font-bold" style="font-family: 'Montserrat', sans-serif;" target="_blank">METAMASK</a><br/>
            2. Je clique sur le bouton “mint”<br/>
            3. Une transaction est créée et je valide les frais de service blockchain ainsi que le prix du mint<br/>
            4. Je reçois le NFT dans mon wallet</p>
        </div>
      </div>
    </section>
  </main>
  <footer class="bg-white py-4 px-4 text-center">
    <p class="clay-secondary">© 2023</p>
  </footer>
  </body>
</template>

<script>
export default {
  name: 'IndexPage',
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap');

.clay-bg {
  background-color: #e6faf3;
}
.clay-primary {
  color: #053a32;
}
.clay-secondary {
  color: #7b7166;
}
.clay-button {
  background-color: #045d56;
  color: #ffffff;
}
.clay-button:hover {
  background-color: #033e39;
}
</style>
