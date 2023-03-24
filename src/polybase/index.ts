import { Auth } from "@polybase/auth";
import { Polybase } from "@polybase/client";
import { ethPersonalSignRecoverPublicKey } from "@polybase/eth";

export const db = new Polybase({
  defaultNamespace:
    "pk/0x764ea6ebf15511fd713867b01bfe8069972c91bba28eac618996a0793e35fe800856044170211ee99896d036baed2b3e8434b78f91ff4870791f0115581253dd/",
});

export const attestationCollection = db.collection("Attestation");
export const metadataCollection = db.collection("GlobalNFTMetadata");

export const createAttRecord = async () => {
  await attestationCollection.create([
    "1",
    "test",
    "true",
    "0x46484hhi9dhs",
    "0x4s5e7f6a",
  ]);
};

export const createNFTRecord = async () => {
  await metadataCollection.create([
    "1",
    "Global NFT 1",
    "http:exmaple.com/image/1",
    "Global nft for attestations",
  ]);

  // db.signer(async (data: string) => {
  //   return {
  //     h: "eth-personal-sign",
  //     sig: await auth.ethPersonalSign(data),
  //   };
  // });
};

export const setNFTAttribute = async () => {
  const atst = attestationCollection.record("1");
  await metadataCollection.record("1").call("setAttributes", [atst]);
};

export const readNFT = async () => {
  const records = metadataCollection.get();
  console.log("records", records);
};

export const auth = new Auth();

export async function getPublicKey() {
  const msg = "Sunscribe to NFTGlobaldata";
  const sig = await auth.ethPersonalSign(msg);
  const publicKey = ethPersonalSignRecoverPublicKey(sig, msg);
  return "0x" + publicKey.slice(4);
}
