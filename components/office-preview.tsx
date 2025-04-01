import { memo } from 'react';

interface OfficePreviewProps {
  file: {
    url: string;
    name: string;
  };
}

const OfficePreview = ({ file }: OfficePreviewProps) => {
  const getOfficePreviewUrl = (fileUrl: string) => {
    const timestamp = new Date().getTime();
    const encodedUrl = encodeURIComponent(fileUrl);
    return `https://view.officeapps.live.com/op/embed.aspx?src=${encodedUrl}&embedded=true&ui=true&rs=false&postMessageOrigin=${encodeURIComponent(window.location.origin)}&wdAllowInteractivity=True&wdHideGridlines=True&wdHideHeaders=True&wdDownloadButton=True&wdInConfigurator=True&_=${timestamp}`;
  };

  return (
    <iframe
      src={getOfficePreviewUrl(file.url)}
      title={file.name}
      className="w-full h-full rounded-t-lg"
    />
  );
};

export const MemoizedOfficePreview = memo(OfficePreview); 