import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';

export async function getPublicFileUrls() {
  const supabase = createClientComponentClient();
  
  // Get current user
  const { data: { user } } = await supabase.auth.getUser();
  console.log('Current user:', user?.id); // Debug log

  if (!user) {
    console.log('No user found');
    return [];
  }

  // Get files associated with the user
  const { data: files, error } = await supabase
    .from('files')
    .select('*')
    .eq('user_id', user.id);

  console.log('Files from database:', files); // Debug log
  console.log('Query error if any:', error); // Debug log

  if (error || !files) {
    console.error('Error fetching files:', error);
    return [];
  }

  // Get public URLs for each file
  const fileUrls = await Promise.all(files.map(async (file) => {
    const { data: publicUrl } = supabase
      .storage
      .from('files') // your bucket name
      .getPublicUrl(`${file.user_id}/${file.name}`);

    return {
      name: file.name,
      url: publicUrl.publicUrl
    };
  }));

  console.log('Generated file URLs:', fileUrls); // Debug log
  return fileUrls;
} 