import { ConnectButton } from "@rainbow-me/rainbowkit";
import { useAccount } from "wagmi";

import { Attestooooooor } from "./components";
import {
  auth,
  createAttRecord,
  createNFTRecord,
  db,
  getPublicKey,
} from "./polybase";

export function App() {
  /**
   * Wagmi hook for getting account information
   * @see https://wagmi.sh/docs/hooks/useAccount
   */
  const { isConnected } = useAccount();

  const signIn = async () => {
    console.log("sign In");
    const res = await auth.signIn();

    console.log("auth state", res);

    // get public
    let publicKey = res?.publicKey;

    if (!publicKey) {
      publicKey = await getPublicKey();
    }

    db.signer(async (data: string) => {
      return {
        h: "eth-personal-sign",
        sig: await auth.ethPersonalSign(data),
      };
    });

    // createAttRecord();
    // createNFTRecord();
  };

  return (
    <>
      <h1>OP Eth Denver Hackathon</h1>

      {/** @see https://www.rainbowkit.com/docs/connect-button */}
      <ConnectButton />

      {isConnected && (
        <>
          <hr />
          <Attestooooooor />
          <hr />

          <button onClick={signIn}>Polybase signIn</button>
          <button onClick={createNFTRecord}>Create nft record</button>
        </>
      )}
    </>
  );
}
