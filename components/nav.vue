<template>
  <header class="bg-white px-4 py-6">
    <div class="container mx-auto flex items-center justify-between">
      <h1 class="text-2xl clay-primary font-serif font-bold" style="font-family: 'Montserrat', sans-serif;">RoomLab</h1>
      <nav>
        <ul class="flex items-center space-x-4">
          <li v-if="currentAccount">Address : {{ currentAccount }}</li>
          <li v-if="currentAccount">Balance : {{ currentWalletAmount }}</li>
          <li v-if="ens && currentAccount">{{ens}}</li>
          <li v-if="!currentAccount"><button :disabled="connecting" class="wallet-button clay-button py-2 px-4 rounded" @click="connectWallet">{{ (!connecting) ? 'Connect wallet' : 'Connecting ... ' }}</button></li>
          <li v-if="currentAccount"><a href="#faq" class="clay-primary font-bold" style="font-family: 'Montserrat', sans-serif;">My NFTs</a></li>
          <li v-if="currentAccount"><button class="wallet-button clay-button py-2 px-4 rounded" @click="disconnectWallet">Disconnect wallet</button></li>
        </ul>
      </nav>
    </div>
  </header>
</template>

<script>
import {ethers} from 'ethers'
import {getParsedEthersError} from "@enzoferey/ethers-error-parser"
import ContractAbi from '../artifacts/contracts/RoomLab.sol/RoomLabNFT.json'

export default {
  name: 'Nav',
  data () {
    return {
      connecting: false,
      currentAccount: null,
      currentWalletAmount: null,
      ens: null,
    }
  },
  methods: {
    // connect metamask wallet
    async connectWallet () {
      try {
        // check if metamask is found
        if (!this.ethereum) {
          console.log('Metamask not detected')
          return
        }
        if(process.env.chainId !== this.chainId) {
          await this.changeNetwork()
        }
        localStorage.clear()
        // get accounts
        const accounts = await this.ethereum.request({ method: 'eth_requestAccounts' })
        const message = 'Welcome !\n\nClick to sign in and login\n\nThis request will not trigger a blockchain transaction or cost any gas fees.\n\nWallet address: '+accounts[0]
        const nonce = 1169868404362723
        await this.ethereum.request({ method: 'personal_sign', params: [accounts[0], message + '\n\nNonce : ' + nonce] })
          .then((res) => {
            const signature = this.contract.verify(accounts[0], message, nonce, res)
            if (signature) {
              this.connecting = true
              this.currentAccount = accounts[0] // set first account to currentAccount
              this.checkWallet() // check balance of account
              this.provider.lookupAddress(this.currentAccount) // set ENS if exist
                .then((res) => {
                  this.ens = res
                })
              localStorage.setItem('storex', JSON.stringify({account: this.currentAccount}))
            } else {
              this.disconnectWallet()
            }
          })
          .catch(
            this.disconnectWallet()
          )
      } catch (error) {
        this.connecting = false
        const parsedEthersError = getParsedEthersError(error);
        if(parsedEthersError.errorCode === 'REJECTED_TRANSACTION'){
          return
        }
        console.log('Error connecting to metamask :', error.message)
      }
    },
    async handleDisconnect () {
      this.chainId = null
      this.currentAccount = null
      this.ens = null
      this.connecting = false
      this.currentWalletAmount = 0
      this.errorTransaction = null
      this.successTransaction = null
      localStorage.clear()
    },
    async disconnectWallet () {
      await this.handleDisconnect()
    },
    async checkWallet () {
      this.loading = true
      try {
        // check if metamask is found
        if (!this.ethereum) {
          console.log('Metamask not detected')
          return
        }
        this.provider.getBalance(this.currentAccount).then((balance) => {
          this.currentWalletAmount = ethers.utils.formatEther(balance)
        })
        this.loading = false
      } catch (error) {
        console.log(error)
        this.loading = false
      }
    },
    async changeNetwork ()  {
      this.loading = true
      try {
        await this.ethereum.request({
          method: 'wallet_switchEthereumChain',
          params: [{ chainId: "0x1" }],
        });
        let network = await this.provider.getNetwork();
        this.chainId = "0x"+network.chainId.toString()+"";
      } catch (error) {
        console.log('Network blockchain not detected')
        console.log(error)
        this.loading = false
      }
    }
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap');

.clay-primary {
  color: #053a32;
}
.clay-button {
  background-color: #045d56;
  color: #ffffff;
}
.clay-button:hover {
  background-color: #033e39;
}
</style>
