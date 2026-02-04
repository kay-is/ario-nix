{
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUgE09xB2WSFpuow24yGsgPoLaEVMFfYC+/S5p+mS69 k@k-lg-gram"
  ];

  dns = {
    email = "fllstck@pm.me";
    provider = "vercel";
    credentialFile = "/root/vercel-token";
  };

  environment = {
    ARNS_ROOT_HOST = "arweave.developerdao.com";
    ADMIN_API_KEY = "permaframes123";
    AR_IO_WALLET = "LSKZ5taMANhACaEHwlY_gzlltF_PwRI3AgAPMLNw5JE";
    RUN_OBSERVER = "false";
    CONTIGUOUS_DATA_CACHE_CLEANUP_THRESHOLD = "86400";
  };
}
